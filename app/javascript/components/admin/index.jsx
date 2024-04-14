import React, { useEffect, useState, useContext } from "react";
import { AppProvider } from "@/contexts";
import { LayoutProvider } from "./layout";

export function Provider({ children }) {
  return (
    <AppProvider>
      <LayoutProvider>
        {children}
      </LayoutProvider>
    </AppProvider>
  )
}
