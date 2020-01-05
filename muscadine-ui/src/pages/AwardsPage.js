import React from "react";
import Awards from "../components/Awards";
import Header from "../components/Header";

import "../stylesheets/publish.css";

export default class AwardsPage extends React.Component {
  render() {
    return (
      <div className="App">
        <Header />
        <div class="publish">
          <table class="table" border="1">
            <tbody>
              <tr id="awards_bar">
                <th colspan="2">Individual Awards</th>
              </tr>
              <tr>
                <td class="awards_cell">
                  <Awards entry_class="ISVM" />
                </td>
                <td class="awards_cell">
                  <Awards entry_class="ISVF" />
                </td>
              </tr>
              <tr>
                <td class="awards_cell">
                  <Awards entry_class="ISJVM" />
                </td>
                <td class="awards_cell">
                  <Awards entry_class="ISJVF" />
                </td>
              </tr>
              <tr>
                <td class="awards_cell">
                  <Awards entry_class="ISIM" />
                </td>
                <td class="awards_cell">
                  <Awards entry_class="ISIF" />
                </td>
              </tr>
              <tr>
                <td class="awards_cell">
                  <Awards entry_class="ISPM" />
                </td>
                <td class="awards_cell">
                  <Awards entry_class="ISPF" />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}
