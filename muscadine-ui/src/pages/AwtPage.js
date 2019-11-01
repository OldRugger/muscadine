import React, { useState, useEffect } from "react";
import Header from "../components/Header";
import AwtRules from "../components/AwtRules";
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
      <AwtRules />
    </div>
  );
}
