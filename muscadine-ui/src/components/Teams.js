import React, { useState, useEffect } from "react";
import "../App.css";
import Category from "../components/Category";
import axios from "axios";

export default function Teams() {
  const initialTeamState = {
    teams: {},
    loading: true
  };
  const [teams, setTeams] = useState(initialTeamState);
  // TODO: get category list from server
  const cat = ["isv", "isjv", "isi", "isp", "jrotc"];

  useEffect(() => {
    const getTeams = async () => {
      const { data } = await axios(
        "http://" + window.location.hostname + ":5000/results/teams"
      );
      console.log(data);
      setTeams(data);
    };

    // Invoke the async function
    getTeams();
  }, []); // Don't forget the `[]`, which will prevent useEffect from running in an infinite loop
  return teams.loading ? (
    <div className="App">Loading...</div>
  ) : (
    <div className="App">
      <div className="team-header">Team Results</div>
      <table className="teams-table">
        <thead>
          <tr className="teams-row-header">
            {cat
              .filter(cat => teams.classes[cat].length > 0)
              .map(cat => {
                return <th key={cat}>{cat.toUpperCase()}</th>;
              })}
          </tr>
        </thead>
        <tbody>
          <tr className="teams-row">
            {cat
              .filter(cat => teams.classes[cat].length > 0)
              .map(cat => {
                return (
                  <td className="team-results" key={cat}>
                    <table>
                      <Category cat={cat} teams={teams} />
                    </table>
                  </td>
                );
              })}
          </tr>
        </tbody>
      </table>
    </div>
  );
}
