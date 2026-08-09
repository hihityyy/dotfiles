#include <cstdlib>
#include <fstream>
#include <iostream>
#include <nlohmann/json.hpp>
#include <sstream>
#include <string>

using json = nlohmann::json;
using namespace std;

const char *MAP = "/tmp/niri-map";
string last_app;
int was_ru = 0;

string exec(const char *cmd) {
  FILE *pipe = popen(cmd, "r");
  string res;
  char buf[256];
  while (fgets(buf, sizeof(buf), pipe))
    res += buf;
  pclose(pipe);
  if (!res.empty() && res.back() == '\n')
    res.pop_back();
  return res;
}

int get_layout() {
  return stoi(exec("niri msg --json keyboard-layouts | jq -r '.current_idx'"));
}

void switch_layout(int idx) {
  system(("niri msg action switch-layout " + to_string(idx)).c_str());
}

void save_map(int id, const string &app, bool append) {
  ofstream f(MAP, append ? ios::app : ios::trunc);
  f << id << " " << app << "\n";
}

string get_app(int id) {
  ifstream f(MAP);
  string line, app;
  while (getline(f, line)) {
    istringstream iss(line);
    int wid;
    if (iss >> wid >> app && wid == id)
      return app;
  }
  return "";
}

int main() {
  FILE *pipe = popen("niri msg --json event-stream", "r");
  char buf[4096];

  while (fgets(buf, sizeof(buf), pipe)) {
    try {
      json e = json::parse(buf);
      string type;
      for (auto &[key, val] : e.items()) {
        type = key;
        break;
      }
      string app;

      if (type == "WindowsChanged") {
        system(("echo '' > " + string(MAP)).c_str());
        for (auto &w : e["WindowsChanged"]["windows"]) {
          save_map(w["id"], w["app_id"], true);
        }
      } else if (type == "WindowOpenedOrChanged") {
        auto w = e["WindowOpenedOrChanged"]["window"];
        save_map(w["id"], w["app_id"], true);
        if (w["is_focused"])
          app = w["app_id"];
      } else if (type == "WindowFocusChanged") {
        app = get_app(e["WindowFocusChanged"]["id"]);
      }

      if (!app.empty()) {
        int layout = get_layout();
        if (app == "kitty" && last_app != "kitty") {
          was_ru = (layout == 1);
          switch_layout(layout == 1 ? 0 : layout);
        } else if (app != "kitty" && last_app == "kitty" && was_ru) {
          switch_layout(1);
        }
        last_app = app;
      }
    } catch (...) {
    }
  }
  pclose(pipe);
}
