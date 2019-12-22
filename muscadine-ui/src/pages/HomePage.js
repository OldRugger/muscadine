import React from "react";
import { Link } from "react-router-dom";
import Header from "../components/Header";
import "../App.css";

export default class HomePage extends React.Component {
  clearResults = function() {
    var xhr = new XMLHttpRequest();
    xhr.addEventListener("load", () => {
      alert(xhr.responseText);
    });
    xhr.open(
      "POST",
      "http://" + window.location.hostname + ":5000/results/clear"
    );
    xhr.send();
  };
  render() {
    return (
      <div className="App">
        <Header />
        <p>
          <button onClick={() => this.clearResults()}>Clear Results</button>
        </p>

        <p>
          <Link to="/results">Results</Link>
        </p>
        <p>
          <Link to="/config">Configuration</Link>
        </p>
        <p>
          <Link to="/teams">Team Results</Link>
        </p>
      </div>
    );
  }
}
