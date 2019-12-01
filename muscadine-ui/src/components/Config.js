import React from "react";

import axios from "axios";
import "../App.css";
import ConfigPage from "../pages/ConfigPage";

export default class ShowRunners extends React.Component {
  constructor() {
    super();
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  state = {
    config: []
  };

  componentDidMount() {
    this.loadConfigData();
  }

  loadConfigData() {
    axios
      .get("http://" + window.location.hostname + ":5000/config")
      .then(res => {
        const config = res.data;
        this.setState({ config });
      });
  }

  handleChangeEvent(val) {
    return val;
  }
  handleSubmit(event) {
    event.preventDefault();
    const form = event.target;
    const formData = new FormData(form);
    var data = {};
    formData.forEach((value, key) => {
      data[key] = value;
    });
    const url =
      "http://" +
      window.location.hostname +
      ":5000/config/" +
      this.state.config.id;
    debugger;
    axios.put(url, data).then(
      response => {
        alert("config update");
      },
      error => {
        alert("config update failed");
        console.log(error);
      }
    );
    this.loadConfigData();
    this.forceUpdate();
  }
  render() {
    return (
      <div>
        <h2>Configuration</h2>
        <form onSubmit={this.handleSubmit}>
          <table className="center">
            <thead>
              <tr>
                <th>Key</th>
                <th>value</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <label for="title">Title</label>
                </td>
                <td>
                  <input
                    name="title"
                    type="text"
                    defaultValue={this.state.config.title}
                    size="38"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.title);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="hotfolder">Hotfolder</label>
                </td>
                <td>
                  <input
                    id="hotfolder"
                    defaultValue={this.state.config.hotfolder}
                    size="38"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="max_time">Max Time</label>
                </td>
                <td>
                  <input
                    id="max_time"
                    defaultValue={this.state.config.max_time}
                    size="38"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="day">Meet day</label>
                </td>
                <td>
                  <input
                    id="day"
                    defaultValue={this.state.config.day}
                    size="38"
                  />
                </td>
              </tr>
            </tbody>
          </table>
          <br />
          <table className="center">
            <thead>
              <tr>
                <th>Key</th>
                <th>Input CSVValue</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <label for="unique_id">Unique Id</label>
                </td>
                <td>
                  <input
                    id="unique_id"
                    defaultValue={this.state.config.unique_id}
                    size="15"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="firstname">First name</label>
                </td>
                <td>
                  <input
                    id="firstname"
                    defaultValue={this.state.config.firstname}
                    size="15"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="lastname">Last name</label>
                </td>
                <td>
                  <input
                    id="lastname"
                    defaultValue={this.state.config.lastname}
                    size="15"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="entry_class">Entry class</label>
                </td>
                <td>
                  <input
                    id="entry_class"
                    defaultValue={this.state.config.entry_class}
                    size="15"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="gender">Gender</label>
                </td>
                <td>
                  <input
                    id="gender"
                    defaultValue={this.state.config.gender}
                    size="15"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="school">School</label>
                </td>
                <td>
                  <input
                    id="school"
                    defaultValue={this.state.config.school}
                    size="15"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="team">Team</label>
                </td>
                <td>
                  <input
                    id="team"
                    defaultValue={this.state.config.team}
                    size="15"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="time">Time</label>
                </td>
                <td>
                  <input
                    id="time"
                    defaultValue={this.state.config.time}
                    size="15"
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="classifier">Classifier</label>
                </td>
                <td>
                  <input
                    id="classifier"
                    defaultValue={this.state.config.classifier}
                    size="15"
                  />
                </td>
              </tr>
            </tbody>
          </table>
          <br />
          <br />
          <button>Update</button>
        </form>
      </div>
    );
  }
}
