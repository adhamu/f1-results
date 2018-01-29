import React from 'react';
import Nav from './nav';
import Home from './home';
import About from './about';
import Contact from './contact';
import Footer from './footer';
import {Route} from 'react-router-dom';

class App extends React.Component {
    render() {
        return (
            <div>
                <Nav/>
                <div className="container">
                    <Route exact path="/" component={Home}/>
                    <Route path="/about" component={About}/>
                    <Route path="/contact" component={Contact}/>
                </div>
                <Footer/>
            </div>
        );
    }
}

export default App;
