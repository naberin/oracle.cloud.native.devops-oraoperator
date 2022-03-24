import React from "react";
import "./header.css";

class Component extends React.Component {
    render() {
        return (
            <header className="app-header">
                <div className={"container flex flex-row"}>
                    <div className="title flex-grow-8 flex flex-col">
                        <div>
                            <img></img>
                            <h3 className="app-title">CloudBank</h3>
                        </div>
                        <div className={"app-description"}>A demo application for Oracle DB Operator For Kubernetes with DevOps and Observability</div>
                    </div>
                    <div className={"actions"}>

                    </div>
                </div>
            </header>
        )
    }
}

export default Component;