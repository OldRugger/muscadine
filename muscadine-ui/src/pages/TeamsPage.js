import React from "react";
import Header from "../components/Header";
import Awt from "../components/Awt";

import "../App.css";

export default class TeamsPage extends React.Component {
  render() {
    return (
      <div className="App">
        <Header />
        <Awt />
        <h2>teams</h2>
      </div>
    );
  }
}
