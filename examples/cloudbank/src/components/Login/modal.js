import React from "react";
import {Link} from "react-router-dom";

class Modal extends React.Component {

    submit = () => {

    }

    render() {
        return (
            <div className={"modal flex flex-col"}>
                <div className={"modal-header"}>


                </div>
                <div className={"title flex flex-row flex-justify-center"}>
                    <span>Login</span>
                </div>

                <form id={"app"} className={"form"} onSubmit={() => this.submit()}>
                    <div className={"fields flex flex-col"}>

                        <div className={"username field flex flex-col"}>
                            <label for={"app-username"}>Username</label>
                            <input type={"text"} id={"app-username"} className={"app-field"}/>
                        </div>

                        <div className={"password field flex flex-col"}>
                            <label for={"app-password"}>Password</label>
                            <input type={"password"} id={"app-password"} className={"app-field"}/>
                            <Link to={"/forgot"} className={"link login-link"}>Forgot username/password?</Link>
                        </div>
                    </div>
                    <div className={"actions flex flex-col"}>
                        <input type={"submit"} className={"submit signin app-button"} value={"Sign In"} />
                        <Link to={"/signup"} className={"submit signup app-button"}>I don't have an account</Link>
                    </div>
                </form>

            </div>

        )
    }
}

export default Modal;