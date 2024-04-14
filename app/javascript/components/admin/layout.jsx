import React, { createContext, useContext, useEffect, useState } from "react";
import axios from 'axios';
import { isMobile, isDesktop, isTablet } from 'react-device-detect';
import Sidebar from "./sidebar";

const LayoutContext = createContext({});

export function LayoutProvider({ children }) {
  const [loading, setLoading] = useState(false);
  const [openSidebar, setOpenSidebar] = useState(false);

  return (
    <LayoutContext.Provider value={{loading, setLoading, openSidebar, setOpenSidebar}}>
      <div className="min-h-screen bg-blue-gray-50/50">
        <Sidebar/>
        <div className="p-4 xl:ml-80 ">
          {children}
        </div>
      </div>
    </LayoutContext.Provider>
  );
}

export function useLayout() {
  const context = useContext(LayoutContext);

  if (typeof context === "undefined") {
    throw new Error(
      "useApp should be used within the AppProvider provider!",
    );
  }

  return context;
}
