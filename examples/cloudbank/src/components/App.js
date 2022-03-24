import './App.css';

import Header from "./Header";
import Login from "./Login";

import React from "react";
import { Routes, Route } from "react-router-dom";
import Footer from "./Footer";


function App() {
  return (
      <div className={"root flex flex-col"}>
        <Header/>
        <Routes>
            <Route path="/login" element={<Login />} />

        </Routes>
          <Footer />
      </div>
  );
}

export default App;
