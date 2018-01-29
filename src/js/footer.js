import React from 'react';

class Footer extends React.Component {
    render() {
        const year = new Date().getFullYear();

        return (
            <div className="fixed-bottom">
                <div className="container">
                    Copyright &copy; {year}
                </div>
            </div>
        );
    }
}

export default Footer;
