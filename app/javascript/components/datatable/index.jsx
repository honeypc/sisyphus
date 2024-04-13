import React, { useEffect, useState } from "react";
import DataGrid from 'react-data-grid';
import axios from "axios";

export function DataTable(props = {}) {
  const [page, setPage] = useState(1)
  const [columns, setColumns] = useState([])
  const [rows, setRows] = useState([])
  const fetchData = function () {
    axios.get(`/tenants.json?page=${page}`).then(function(response) {
      console.log(response);
      setColumns(response.data.columns)
      setRows(response.data.rows)
    })
  }

  useEffect(() => {
    fetchData();
  }, [])

  return (
    <DataGrid columns={columns} rows={rows} />
  )
}
