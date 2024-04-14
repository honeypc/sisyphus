import React, { useEffect, useState } from "react";
import DataGrid from 'react-data-grid';
import axios from "axios";

export function DataTable(props = {}) {
  const [page, setPage] = useState(1)
  const [columns, setColumns] = useState([])
  const [rows, setRows] = useState([])
  const fetchData = function () {
    axios.get(`/tenants.json?page=${page}`).then(function(response) {
      setColumns(response.data.columns)
      setRows(response.data.rows)
    })
  }

  useEffect(() => {
    fetchData();
  }, [])

  return (
    <div className="relative flex flex-col bg-clip-border rounded-xl bg-white text-gray-700 overflow-hidden xl:col-span-2 border border-blue-gray-100 shadow-sm">
      <div className="relative bg-clip-border rounded-xl overflow-hidden bg-transparent text-gray-700 shadow-none m-0 flex items-center justify-between p-6"></div>
      <div className="p-6 overflow-x-scroll px-0 pt-0 pb-2">
        <DataGrid className="w-full min-w-[640px] table-auto" columns={columns} rows={rows} />
      </div>
    </div>
  )
}
