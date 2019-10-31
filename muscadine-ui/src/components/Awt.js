import React, { useState, useEffect } from "react";
import "../App.css";
import axios from "axios";

export default function AwtPage() {
  const initialAwtState = {
    Awt: {},
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
  useEffect(() => {
    const getAwt = async () => {
      const { data } = await axios(`http://localhost:5000/results/awt`);
      setAwt(data);
    };

    // Invoke the async function
    getAwt();
  }, []); // Don't forget the `[]`, which will prevent useEffect from running in an infinite loop

  return awt.loading ? (
    <div className="App">Loading...</div>
  ) : (
    <div className="App">
      <div className="awt-header">Average Weighted Time</div>

      <table className="awt-table">
        <thead>
          <tr className="awt-day-header">
            <td colSpan={9}>Day1</td>
            <td colSpan={9}>Day2</td>
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
        </tbody>
      </table>
    </div>
  );
}
