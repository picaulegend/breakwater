import React from "react";
import { render } from "react-dom";
import Provider from "../components/Provider";
import Farm from "../components/Farm";

render(
  <Provider>
    <Farm />
  </Provider>,
  document.querySelector("#root")
);
