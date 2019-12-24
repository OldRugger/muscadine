import React from "react";
import { Link } from "react-router-dom";
import "../App.css";

export default class Category extends React.Component {
  constructor(props) {
    super(props);
    this.cat = props.cat;
    this.results = props.teams.classes[this.cat];
    this.day1Hash = props.teams.awt.day1;
    this.day2Hash = props.teams.awt.day2;
    let self = this;
    this.results = this.results.map(function(team, index) {
      team["day1"] = self.day1Hash[team.name];
      team["day2"] = self.day2Hash[team.name];
      team["place"] = index + 1;
      return team;
    });
  }
  render() {
    return (
      <tbody>
        {this.results.map(team => {
          return (
            <tr key={team.name}>
              <td className="team-results">{team.place}</td>
              <td className="team-results">
                <b>
                  <Link to={"/teams/" + team.id}>{team.name}</Link>
                </b>{" "}
                ({team.total_score.toFixed(3)})<br />
                <b>Day1: </b>
                {team.day1 ? team.day1.results : "n/a"}
                <br />
                <b>Day2: </b>
                {team.day2 ? team.day2.results : "n/a"}
                <br />
              </td>
            </tr>
          );
        })}
      </tbody>
    );
  }
}
