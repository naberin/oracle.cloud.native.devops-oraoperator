import React from "react";
import "./login.css";
import LoginModal from "./modal";

class Component extends React.Component {
    render() {
        return (
            <section className="login app-section flex-grow-8">
                <LoginModal/>
            </section>
        )
    }
}

export default Component;