import { Controller } from "@hotwired/stimulus"
import React, { useState } from "react";
import ReactDOM from "react-dom/client";
import { DataTable } from "../components/datatable";
import axios from "axios";

// Connects to data-controller="react"
export default class extends Controller {
  connect() {
    console.log("Connected react app")
    const root = ReactDOM.createRoot(document.getElementById("app"));
    root.render(
      <DataTable />
    )
  }
}
