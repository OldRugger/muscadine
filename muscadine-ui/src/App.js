import React from "react";
import { Route, Switch } from "react-router-dom";
import HomePage from "./pages/HomePage";
import ConfigPage from "./pages/ConfigPage";
import TeamsPage from "./pages/TeamsPage";
import AwtPage from "./pages/AwtPage";

export default function App() {
  return (
    <Switch>
      <Route exact path="/" component={HomePage} />
      <Route path="/config" component={ConfigPage} />
      <Route path="/teams" component={TeamsPage} />
      <Route path="/awt" component={AwtPage} />
    </Switch>
  );
}
