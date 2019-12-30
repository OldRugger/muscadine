import React from "react";
import "../stylesheets/publish.css";
import PublishResults from "../components/PublishResults";
import Header from "../components/Header";

export default class PublishPage extends React.Component {
  render() {
    return (
      <div className="App">
        <Header />
        <PublishResults />
      </div>
    );
  }
}
