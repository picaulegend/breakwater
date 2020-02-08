import React from "react";
import { render } from "react-dom";
import Provider from "../components/Provider";
import App from "../components/App";

render(
  <Provider>
    <App />
  </Provider>,
  document.querySelector("#root")
);
