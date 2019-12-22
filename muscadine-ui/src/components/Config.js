import React from "react";
import axios from "axios";
import "../App.css";
import ConfigPage from "../pages/ConfigPage";

export default class ShowRunners extends React.Component {
  constructor() {
    super();
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleReset = this.handleReset.bind(this);
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
    axios.put(url, data).then(
      response => {
        alert("config updated");
      },
      error => {
        alert("config update failed");
        console.log(error);
      }
    );
    window.location.reload(false);
  }
  handleReset(event) {
    event.preventDefault();
    const form = event.target;
    const url = "http://" + window.location.hostname + ":5000/config/load";
    axios.post(url).then(
      response => {
        alert("config reset");
      },
      error => {
        alert("config reset failed");
        console.log(error);
      }
    );
    window.location.reload(false);
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
                    name="hotfolder"
                    type="text"
                    defaultValue={this.state.config.hotfolder}
                    size="38"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.title);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="max_time">Max Time</label>
                </td>
                <td>
                  <input
                    name="max_time"
                    type="integer"
                    defaultValue={this.state.config.max_time}
                    size="38"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.title);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="day">Meet day</label>
                </td>
                <td>
                  <input
                    name="day"
                    type="integer"
                    defaultValue={this.state.config.day}
                    size="38"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.day);
                    }}
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
                <th>Input CSV Values</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <label for="unique_id">Unique Id</label>
                </td>
                <td>
                  <input
                    name="unique_id"
                    type="text"
                    defaultValue={this.state.config.unique_id}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.unique_id);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="firstname">First name</label>
                </td>
                <td>
                  <input
                    name="firstname"
                    type="text"
                    defaultValue={this.state.config.firstname}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.firstname);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="lastname">Last name</label>
                </td>
                <td>
                  <input
                    name="lastname"
                    type="text"
                    defaultValue={this.state.config.lastname}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.lastname);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="entry_class">Entry class</label>
                </td>
                <td>
                  <input
                    name="entry_class"
                    type="text"
                    defaultValue={this.state.config.entry_class}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.entry_class);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="gender">Gender</label>
                </td>
                <td>
                  <input
                    name="gender"
                    type="text"
                    defaultValue={this.state.config.gender}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.gender);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="school">School</label>
                </td>
                <td>
                  <input
                    name="school"
                    type="text"
                    defaultValue={this.state.config.school}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.school);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="team">Team</label>
                </td>
                <td>
                  <input
                    name="team"
                    type="text"
                    defaultValue={this.state.config.team}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.team);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="time">Time</label>
                </td>
                <td>
                  <input
                    name="time"
                    type="text"
                    defaultValue={this.state.config.time}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.time);
                    }}
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <label for="classifier">Classifier</label>
                </td>
                <td>
                  <input
                    name="classifier"
                    type="text"
                    defaultValue={this.state.config.classifier}
                    size="15"
                    onChange={() => {
                      this.handleChangeEvent(this.state.config.classifier);
                    }}
                  />
                </td>
              </tr>
            </tbody>
          </table>
          <br />
          <button>Update</button>
        </form>
        <br />
        <form onSubmit={this.handleReset}>
          <button>Reset Defaults</button>
        </form>
      </div>
    );
  }
}
