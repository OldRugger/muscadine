import React from "react";
import Header from "../components/Header";
import ShowRunners from "../components/ShowRunners";

import "../App.css";

export default class RunnersPage extends React.Component {
  render() {
    return (
      <div className="App">
        <Header />
        <table className="import-table">
          <tbody>
            <tr>
              <td colSpan="2">
                <ShowRunners />
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    );
  }
}
