import {Link} from "react-router-dom";
import "./index.css";


const Component = function(props) {

    return (
        <div className={"container flex flex-row flex-justify-space-between transfer-header"}>
            <div className={"left flex flex-row"}>
                <Link to={"/"} className={"nav app-button transfer current"}>Make Transfer</Link>
                <Link to={"/history"} className={"nav app-button"}>Past Transfers</Link>
            </div>
        </div>
    )
}
export default Component;