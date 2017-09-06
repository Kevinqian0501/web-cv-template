import logging
from flask import Flask, render_template, request



app = Flask(__name__)
logging.basicConfig(level=logging.DEBUG)

@app.route('/', methods=['GET', 'POST'])
def main():
    if request.method == 'POST':
        #return render_template('view.html', image_url=img_url, predictions=predictions['predictions'])
        return render_template(
            'index.html'
        )    
    return render_template('index.html')


@app.errorhandler(500)
def server_error(e):
    logging.error('An error occurred during a request.')
    return 'An internal error occurred.', 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5555, debug=True)