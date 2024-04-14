import PropTypes from "prop-types";
import React, { createContext, useContext, useEffect, useState } from "react";
import {
  Avatar,
  Button,
  IconButton,
  Typography,
} from "@material-tailwind/react";
import { useLayout } from "./layout";

const Sidebar = function(props) {
  const { openSidebar, setOpenSidebar } = useLayout()

  return (
    <aside className={`bg-white shadow-sm dark:bg-gradient-to-br dark:from-gray-800 dark:to-gray-900 ${
      openSidebar ? "translate-x-0" : "-translate-x-80"
    } fixed inset-0 z-50 my-4 ml-4 h-[calc(100vh-32px)] w-72 rounded-xl transition-transform duration-300 xl:translate-x-0 border border-blue-gray-100`}>
      <div className="m-4">
        <ul className="mb-4 flex flex-col gap-1">
          <li className="mx-3.5 mt-4 mb-2">
            <Typography
              variant="small"
              className="blue-gray font-black uppercase opacity-75 dark:white"
            >
              Dashboard
            </Typography>
          </li>
        </ul>
      </div>
    </aside>
  )
}

export default Sidebar;
