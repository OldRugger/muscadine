import React from "react";

import axios from "axios";

export default class ShowRunners extends React.Component {
  state = {
    results: []
  };

  componentDidMount() {
    axios
      .get("http://" + window.location.hostname + ":5000/teams2")
      .then(res => {
        const results = res.data;
        this.setState({ results });
        console.log(results);
      });
  }

  createAwtColumns = () => {
    let cells = [];
    for (let i = 0; i < 2; i++) {
      cells.push(<td class="awt_cat_b">Class</td>);
      if (this.state.results.classes !== undefined) {
        this.state.results.class_list.forEach(item => {
          cells.push(<th class="awt_cat">{item.toUpperCase()}</th>);
        });
      }
    }
    return cells;
  };

  getIsiAwtResults = (row, day) => {
    console.log(row + "   " + day);
    let cells = [];
    if (this.state.results.classes !== undefined) {
      this.state.results.class_list.forEach(item => {
        console.log(this.state.results.awt[day][item + row]);
        cells.push(
          <td>
            {this.state.results.awt[day][item + row]
              ? this.state.results.awt[day][item + row]
              : "n/a"}
          </td>
        );
      });
    }
    return cells;
  };

  getIsiAwtValues = day => {
    let cells = [];
    if (this.state.results.class_list !== undefined) {
      this.state.results.class_list.forEach(item => {
        cells.push(
          <td>
            {this.state.results.awt[day][item]
              ? this.state.results.awt[day][item]
              : "n/a"}
          </td>
        );
      });
    }
    return cells;
  };

  getAwtDayResults = n => {
    let cells = [];
    for (let i = 0; i < 2; i++) {
      cells.push(<td class="awt_cat_b">Runner {n + 1} </td>);
      cells.push(this.getIsiAwtResults(n + 1, i + 1));
    }
    return cells;
  };

  getAwtDayValues = () => {
    let cells = [];
    for (let i = 0; i < 2; i++) {
      cells.push(<td class="awt_cat_b">AWT</td>);
      cells.push(this.getIsiAwtValues(i + 1));
    }
    return cells;
  };

  getAwtResults = () => {
    let cells = [];
    for (let i = 0; i < 3; i++) {
      cells.push(<tr>{this.getAwtDayResults(i)}</tr>);
    }
    cells.push(<tr id="awt_line">{this.getAwtDayValues()}</tr>);
    return cells;
  };

  getTeamClasses = () => {
    let cells = [];
    if (this.state.results.classes !== undefined) {
      this.state.results.cat_list.forEach(cat => {
        if (this.state.results.classes[cat].length > 0) {
          cells.push(<th>{cat.toUpperCase()}</th>);
        }
      });
    }
    return cells;
  };

  getRunnerDetails(runner) {
    let cells = [];
    let day1 = "";
    let day2 = "";
    console.log(runner);
    cells.push(
      <td width="60%" class="left_justified">
        {runner.firstname} {runner.surname}
      </td>
    );
    if (
      runner.day1_score &&
      runner.day1_score !== 9999 &&
      runner.day1_score > 0
    ) {
      day1 = Math.round(runner.day1_score * 1000) / 1000;
    }
    if (
      runner.day2_score &&
      runner.day2_score !== 9999 &&
      runner.day2_score > 0
    ) {
      day2 = Math.round(runner.day2_score * 1000) / 1000;
    }
    cells.push(
      <td width="20%" class="right_justified">
        {day1}
      </td>
    );
    cells.push(
      <td width="20%" class="right_justified">
        {day2}
      </td>
    );
    return cells;
  }

  getTeamRunners(team) {
    let cells = [];
    cells.push(
      <tr>
        <th width="240px" class="left_justified">
          Runner
        </th>
        <th width="55px" class="right_justified">
          Day 1
        </th>
        <th width="55px" class="right_justified">
          Day 2
        </th>
      </tr>
    );
    this.state.results.runners.forEach(runner => {
      if (runner.team_id === team.id) {
        cells.push(<tr>{this.getRunnerDetails(runner)}</tr>);
      }
    });
    return cells;
  }

  getTeamDetails(team) {
    console.log(team);
    let cells = [];
    let score = "";
    let day1 = "";
    let day2 = "";
    if (team.total_score && team.total_score !== 9999 && team.total_score > 0) {
      score = Math.round(team.total_score * 100) / 100;
    }
    if (team.day1_score && team.day1_score !== 9999 && team.day1_score > 0) {
      day1 = Math.round(team.day1_score * 1000) / 1000;
    }
    if (team.day2_score && team.day2_score !== 9999 && team.day2_score > 0) {
      day2 = Math.round(team.day2_score * 1000) / 1000;
    }

    cells.push(
      <td class="left_justified">
        <div class="team_name">
          {team.name} ({score})
        </div>
        <b>
          <i>{team.school}</i>
        </b>{" "}
        - Day 1 ({day1}) - Day 2 ({day2})
        <table width="350px" border="0">
          {this.getTeamRunners(team)}
        </table>
      </td>
    );
    return cells;
  }

  getCatResults(cat) {
    let cells = [];
    let place = 1;
    cat.forEach(team => {
      cells.push(
        <tr>
          <td class="publish_place" valign="top">
            {place}
          </td>
          <td>{this.getTeamDetails(team)}</td>
        </tr>
      );
      place++;
    });
    return cells;
  }

  getTeamResults = () => {
    let cells = [];
    if (this.state.results.classes !== undefined) {
      this.state.results.cat_list.forEach(cat => {
        if (this.state.results.classes[cat].length > 0) {
          cells.push(
            <td valign="top">
              <table>
                {this.getCatResults(this.state.results.classes[cat])}
              </table>
            </td>
          );
        }
      });
    }
    return cells;
  };

  render() {
    return (
      <div className="publish">
        <table class="table">
          <tr id="awt_bar">
            <th class="awt" colspan="18">
              Average Weighted Time
            </th>
          </tr>
          <tr class="header_row">
            <td class="awt_cat" colspan="9">
              Day 1
            </td>
            <td class="awt_cat" colspan="9">
              Day 2
            </td>
          </tr>
          <tr>{this.createAwtColumns()}</tr>
          {this.getAwtResults()}
        </table>
        <br />
        <table class="table">
          <tr id="team_bar">
            <th colspan="100%">Team Results</th>
          </tr>
          <tr class="header_row">{this.getTeamClasses()}</tr>
          <tr>{this.getTeamResults()}</tr>
        </table>
      </div>
    );
  }
}
