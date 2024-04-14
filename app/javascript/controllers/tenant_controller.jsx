import ApplicationController from "./application_controller"
import React from "react";
import ReactDOM from "react-dom/client";
import { DataTable } from "@/components/datatable";
import { Provider } from "@/components/admin";

// Connects to data-controller="react"
export default class extends ApplicationController {
  connect() {
    this.render(
      <Provider><DataTable /></Provider>
    )
  }
}
