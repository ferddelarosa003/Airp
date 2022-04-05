console.log('test')

document.addEventListener('DOMContentLoaded', (event) => {
    //the event occurred
   fetch('http://localhost:3001/seating_sequences/3/populate')
    .then(response => response.json())
    .then(data => console.log(data));
  })

