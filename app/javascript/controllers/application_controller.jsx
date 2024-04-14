import { Controller } from "@hotwired/stimulus";
import React from "react";
import ReactDOM from "react-dom/client";
import { Provider } from "../components";

// Connects to data-controller="react"
export default class extends Controller {
  initialize() {
    this.root = this.root.bind(this);
    this.render = this.render.bind(this);
  }

  connect() {
    console.log('Load app controller')
  }

  root() {
    return ReactDOM.createRoot(document.getElementById("app"));
  }

  render(component) {
    this.root().render(
      <Provider>
        {component}
      </Provider>
    )
  }
}
