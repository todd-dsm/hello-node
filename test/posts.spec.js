//posts.spec.js

const request = require('supertest')
const expect = require('chai').expect

const host = 'http://localhost:3000'

describe('GET /posts endpoint', () => {
  it('GET /posts endpoint successfully returns response', () => {
    return request(host)
      .get('/posts')
      .then((response) => {
        expect(response.statusCode).to.equal(200)
        expect(response.text).to.equal('You have hit GET /posts endpoint')
      })
  })
})
