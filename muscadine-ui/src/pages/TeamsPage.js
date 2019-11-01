import React from "react";
import Header from "../components/Header";
import Awt from "../components/Awt";
import Teams from "../components/Teams";

import "../App.css";

export default class TeamsPage extends React.Component {
  render() {
    return (
      <div className="App">
        <Header />
        <Awt />
        <Teams />
      </div>
    );
  }
}
