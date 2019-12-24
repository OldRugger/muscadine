import React from "react";
import "../App.css";

export default class AwtRules extends React.Component {
  render() {
    return (
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
    );
  }
}
