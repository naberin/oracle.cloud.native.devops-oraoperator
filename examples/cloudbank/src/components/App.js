import './App.css';

import Header from "./Header";
import React from "react";
import { Routes, Route } from "react-router-dom";
import Footer from "./Footer";


function App() {
  return (
      <div className={"root flex flex-col"}>
        <Header/>
        <Routes>

        </Routes>
          <Footer />
      </div>
  );
}

export default App;
