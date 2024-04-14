import React, { createContext, useContext, useEffect, useState } from "react";
import axios from 'axios';
import { isMobile, isDesktop, isTablet } from 'react-device-detect';

const AppContext = createContext({});

export function AppProvider({ children }) {
  const [loading, setLoading] = useState(false)

  return (
    <AppContext.Provider value={{loading, setLoading}}>
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const context = useContext(AppContext);

  if (typeof context === "undefined") {
    throw new Error(
      "useApp should be used within the AppProvider provider!",
    );
  }

  return context;
}
