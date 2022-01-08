import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />

        <p id="UPDATE-HERE">
          Hello! This is v1.0.0
        </p>
        
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          CICD with Microservices
        </a>
      </header>
    </div>
  );
}

export default App;
