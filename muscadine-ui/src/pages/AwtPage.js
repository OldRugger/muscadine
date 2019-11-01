import React, { useState, useEffect } from "react";
import Header from "../components/Header";
import axios from "axios";
import "../App.css";

export default function AwtPage() {
  const initialAwtState = {
    awt: {},
    loading: true
  };
  const [awt, setAwt] = useState(initialAwtState);
  // TODO: get classes list from server;
  const classes = [
    "ISVM",
    "ISVF",
    "ISJVM",
    "ISJVF",
    "ISIM",
    "ISIF",
    "ISPM",
    "ISPF"
  ];

  // Using useEffect to retrieve data from an API (similar to componentDidMount in a class)
  useEffect(() => {
    const getAwt = async () => {
      const { data } = await axios(
        "http://" + window.location.hostname + ":5000/results/awt"
      );
      setAwt(data);
    };

    // Invoke the async function
    getAwt();
  }, []); // Don't forget the `[]`, which will prevent useEffect from running in an infinite loop

  return awt.loading ? (
    <div className="App">
      <Header />
      Loading...
    </div>
  ) : (
    <div className="App">
      <Header />
      <div className="awt-header">Average Weighted Time</div>
      <table className="awt-table">
        <thead>
          <tr className="awt-day-header">
            <td colSpan={9}>Day 1</td>
            <td colSpan={9}>Day 2</td>
          </tr>
          <tr className="awt-col-header">
            <td>Class</td>
            {classes.map(className => {
              return <td key={className}>{className}</td>;
            })}
            <td>Class</td>
            {classes.map(className => {
              return <td key={className}>{className}</td>;
            })}
          </tr>
        </thead>
        <tbody>
          {["1", "2", "3"].map(r => {
            return (
              <tr>
                <td className="awt-row-header">Runner{r}</td>
                {classes.map(className => {
                  return (
                    <td key={className}>
                      {awt[1][className] ? awt[1][className + r] : "n/a"}
                    </td>
                  );
                })}
                <td className="awt-row-header">Runner{r}</td>
                {classes.map(className => {
                  return (
                    <td key={className}>
                      {awt[1][className] ? awt[2][className + r] : "n/a"}
                    </td>
                  );
                })}
              </tr>
            );
          })}
          <tr>
            <td className="awt-row-header">AWT</td>
            {classes.map(className => {
              return (
                <td key={className}>
                  {awt[1][className] ? awt[1][className] : "n/a"}
                </td>
              );
            })}
            <td className="awt-row-header">AWT</td>
            {classes.map(className => {
              return (
                <td key={className}>
                  {awt[1][className] ? awt[2][className] : "n/a"}
                </td>
              );
            })}
          </tr>
          <tr>
            <td className="awt-row-header">CAT</td>
            {classes.map(className => {
              return (
                <td key={className}>
                  {awt[1][className] ? awt[1][className + "_cat"] : "n/a"}
                </td>
              );
            })}
            <td className="awt-row-header">CAT</td>
            {classes.map(className => {
              return (
                <td key={className}>
                  {awt[1][className] ? awt[2][className + "_cat"] : "n/a"}
                </td>
              );
            })}
          </tr>
        </tbody>
      </table>
      <div className="awt-rules">
        <br />
        <b>*</b> No valid runner time for class
        <br />
        AWT (Class AWT) used within the Team score calculation for successful
        runners
        <br />
        CAT AWT (Category AWT) used within the Team score calculation for DNF,
        MP, Disq runners
        <br />
        <br />
        <h3>US Orienteering Scoring rules</h3>
        <h4>
          A.35.4 <em>Scoring</em>
        </h4>
        <p>A.35.4.1 Scores for each race are computed as follows:</p>
        <ol type="a">
          <li>
            For each Individual Intercollegiate class, define AWT (the average
            winning time) as the average of the times of the top three
            individual competitors in that class (for Championships use only
            times from Team Championship-eligible competitors). In the event
            that there are fewer than three eligible competitors with a valid
            time in any intercollegiate class, the AWT shall be calculated as
            the average of the times of all eligible competitors with a valid
            time.
          </li>
          <li>
            For each competitor in each Individual Intercollegiate class with a
            valid result, their score is computed as 60*(competitor’s time)/
            (AWT for the class).
          </li>
          <li>
            For competitors with an OVT, MSP, DNF or DSQ result, their score
            shall be the larger of 10+[60*(course time limit)/ (AWT for the male
            class)] and 10+[60*(course time limit)/ (AWT for the female class)]
            for their team level (Varsity or JV).
          </li>
        </ol>
        <p>
          A.35.4.2 <em>Team Scoring</em>: The best three scores from each race
          for each team are combined for a team score. Lowest overall team score
          wins.
        </p>
      </div>
    </div>
  );
}
