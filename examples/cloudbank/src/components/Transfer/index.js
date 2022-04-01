import React, {useState} from "react";
import TransferNav from "./nav";
import Transfer from "./transfer";

function Component() {

    return (
        <section className={"transfer app-section flex-grow-8"}>
            <TransferNav/>
            <Transfer/>
        </section>
    )
}

export default Component;