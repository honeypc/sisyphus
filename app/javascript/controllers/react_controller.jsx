import { Controller } from "@hotwired/stimulus"
import React from "react";
import ReactDOM from "react-dom/client";
import { SignIn } from "../components/auth/signin";

// Connects to data-controller="react"
export default class extends Controller {
  connect() {
    console.log("Connected react app")
    const root = ReactDOM.createRoot(document.getElementById("app"));
    root.render(
      <SignIn/>
    )
  }
}
