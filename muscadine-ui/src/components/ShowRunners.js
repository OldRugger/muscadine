import React from "react";

import axios from "axios";
import "../App.css";

export default class ShowRunners extends React.Component {
  state = {
    runners: []
  };

  componentDidMount() {
    axios
      .get("http://" + window.location.hostname + ":5000/runners")
      .then(res => {
        const runners = res.data;
        this.setState({ runners });
      });
  }
  render() {
    return (
      <div>
        <h2>Results</h2>
        <table className="runners-table">
          <thead>
            <tr>
              <th>Database Id</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Gender</th>
              <th>School</th>
              <th>Team</th>
              <th>Entry Class</th>
              <th>Day 1 Time</th>
              <th>Classifier1</th>
              <th>Day 1 Score</th>
              <th>Day 2 Time</th>
              <th>Classifier2</th>
              <th>Day 2 Score</th>
              <th>Total Time</th>
              <th>Total Score</th>
            </tr>
          </thead>
          <tbody>
            {this.state.runners.map(r => {
              return (
                <tr>
                  <td>{r.database_id}</td>
                  <td>{r.firstname}</td>
                  <td>{r.surname}</td>
                  <td>{r.gender}</td>
                  <td>{r.school}</td>
                  <td>{r.team_name}</td>
                  <td>{r.entryclass}</td>
                  <td>{r.time1}</td>
                  <td>{r.classifier1}</td>
                  <td>{r.day1_score}</td>
                  <td>{r.time2}</td>
                  <td>{r.classifier2}</td>
                  <td>{r.day2_score}</td>
                  <td>{r.total_time}</td>
                  <td>{r.total_score}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    );
  }
}
