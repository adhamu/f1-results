import 'jquery';
import 'popper.js';
import 'bootstrap';

import React from 'react';
import ReactDOM from 'react-dom';

class App extends React.Component {
    render() {
        return (
            <div>
                <h1>React boi!!!</h1>
            </div>
        );
    }
}

ReactDOM.render(React.createElement(App, null), document.getElementById('app'));
