import React from "react";
import axios from "axios";
import "../App.css";

export default class Awards extends React.Component {
  place = 1;

  state = {
    runners: []
  };

  componentDidMount() {
    axios
      .get(
        "http://" +
          window.location.hostname +
          ":5000/awards?entry_class=" +
          this.props.entry_class
      )
      .then(res => {
        const runners = res.data;
        this.setState({ runners });
      });
  }

  render() {
    return (
      <div>
        <h2>{this.props.entry_class}</h2>
        <table class="awards_table">
          <thead>
            <tr>
              <th></th>
              <th>Runner</th>
              <th>School</th>
              <th>Day 1 Score</th>
              <th>Day 2 Score</th>
              <th>Total Score</th>
            </tr>
          </thead>
          <tbody>
            {this.state.runners.map(r => {
              return (
                <tr>
                  <td>{this.place++}</td>
                  <td class="left_justified">
                    {r.firstname} {r.surname}
                  </td>
                  <td class="left_justified">{r.school}</td>
                  <td>{r.day1_score ? r.day1_score.toFixed(4) : "n/a"}</td>
                  <td>{r.day2_score ? r.day2_score.toFixed(4) : "n/a"}</td>
                  <td>{r.total ? r.total.toFixed(3) : "n/a"}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    );
  }
}
