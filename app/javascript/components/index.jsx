import React, { useEffect, useState, useContext } from "react";
import { AppProvider } from "../contexts";

export function Provider({ children }) {
  return (
    <AppProvider>
      {children}
    </AppProvider>
  )
}
