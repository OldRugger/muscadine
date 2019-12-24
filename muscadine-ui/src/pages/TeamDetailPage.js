import React, { useState, useEffect } from "react";
import Header from "../components/Header";
import AwtRules from "../components/AwtRules";
import axios from "axios";

import "../App.css";

export default function TeamDetailPage(params) {
  let teamId = params.match.params.teamId;

  const initialTeamState = {
    team: {},
    loading: true
  };
  const [data, setData] = useState(initialTeamState);
  // TODO: get classes list from server;

  // Using useEffect to retrieve data from an API (similar to componentDidMount in a class)
  useEffect(() => {
    const getData = async () => {
      const { data } = await axios(
        "http://" + window.location.hostname + ":5000/teams/" + teamId
      );
      setData(data);
    };

    // Invoke the async function
    getData();
  }, []); // Don't forget the `[]`, which will prevent useEffect from running in an infinite loop

  return data.loading ? (
    <div className="App">
      <Header />
      Loading...
    </div>
  ) : (
    <div className="App">
      <Header />
      <div className="team-header">{data.team.name}</div>
      <table className="teams-table">
        <tbody>
          <tr className="teams-row-header">
            <td>Category: {data.team.entryclass}</td>
            <td>JROTC Branch: {data.team.JROTC_branch}</td>
            <td>
              Day 1 score:{" "}
              {data.team.day1_score ? data.team.day1_score.toFixed(3) : "n/a"}
            </td>
            <td>
              Day 2 score:{" "}
              {data.team.day1_score ? data.team.day2_score.toFixed(3) : "n/a"}
            </td>
          </tr>
        </tbody>
      </table>
      <table className="teams-table">
        <thead>
          <tr className="team-detail-row-header">
            <th rowSpan="2">Runner</th>
            <th rowSpan="2">Class</th>
            <th className="team-detail-column-header" colSpan="4">
              Day 1
            </th>
            <th className="team-detail-column-header" colSpan="4">
              Day 2
            </th>
          </tr>
          <tr className="team-detail-row-header">
            <th className="team-detail-column-header">Time</th>
            <th className="team-detail-column-header">Class AWT</th>
            <th className="team-detail-column-header">Category AWT</th>
            <th className="team-detail-column-header">Score</th>
            <th className="team-detail-column-header">Time</th>
            <th className="team-detail-column-header">Class AWT</th>
            <th className="team-detail-column-header">Category AWT</th>
            <th className="team-detail-column-header">Score</th>
          </tr>
        </thead>
        <tbody>
          {data.runners.map(r => {
            return (
              <tr>
                <td className="cell-left">
                  {r.firstname} {r.surname}
                </td>
                <td>{r.entryclass}</td>
                <td>{r.time1.substring(11)}</td>
                <td>{data.day1[r.entryclass].awt}</td>
                <td>{data.day1[r.entryclass].cat}</td>
                <td>{r.day1_score.toFixed(3)}</td>
                <td>{r.time2 ? r.time2.substring(11) : ""}</td>
                <td>
                  {data.day2[r.entryclass] ? data.day2[r.entryclass].awt : ""}
                </td>
                <td>
                  {data.day2[r.entryclass] ? data.day2[r.entryclass].cat : ""}
                </td>
                <td>{r.day2_score ? r.day2_score.toFixed(3) : ""}</td>
              </tr>
            );
          })}
        </tbody>
      </table>
      <AwtRules />
    </div>
  );
}
