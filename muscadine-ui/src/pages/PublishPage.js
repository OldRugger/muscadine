import React from "react";
import "../stylesheets/publish.css";
import PublishResults from "../components/PublishResults";

export default class PublishPage extends React.Component {
  render() {
    return (
      <div className="App">
        <PublishResults />
      </div>
    );
  }
}
