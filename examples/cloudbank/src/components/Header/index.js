import React from "react";
import "./header.css";

class Component extends React.Component {
    render() {
        return (
            <header className="app-header">
                <div className={"container flex flex-row"}>
                    <div className="title flex-grow-8 flex flex-col">
                        <div className={"flex flex-row"}>
                            <img></img>
                            <div className={"flex flex-col"}>
                                <h3 className="app-title">CloudBank</h3>
                                <div className={"app-description"}>A demo application for the OraOperator with Oracle DevOps and observability</div>
                            </div>

                        </div>
                    </div>
                    <div className={"actions"}>

                    </div>
                </div>
            </header>
        )
    }
}

export default Component;