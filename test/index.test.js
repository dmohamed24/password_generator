const request = require('supertest');
const path = require('path');
const fs = require('fs');
const cheerio = require('cheerio');
const { app, server } = require('../src/index');

describe('Express App', () => {
  beforeAll(() => {
    process.env.PORT = 3001;
  });

  afterAll((done) => {
    server.close(done);
  });

  describe('GET /', () => {
    it('should return the index.html page with necessary elements', async () => {
      const response = await request(app).get('/');
      expect(response.statusCode).toBe(200);
      expect(response.header['content-type']).toContain('text/html');
      const html = fs.readFileSync(
        path.join(__dirname, '../public/index.html'),
        'utf-8'
      );
      const $ = cheerio.load(html);
      expect($('#account').length).toBe(1);
      expect($('#generate').length).toBe(1);
      expect($('#saved').length).toBe(1);
    });
  });

  describe('Invalid Route', () => {
    it('should return 404 for undefined route', async () => {
      const response = await request(app).get('/undefined');
      expect(response.statusCode).toBe(404);
    });
  });

  it('should return password with correct length and optional symbols', async () => {
    const response = await request(app)
      .post('/generate')
      .send({ account: 'demo', length: 20, symbols: true });

    expect(response.statusCode).toBe(200);
    expect(response.body.account).toBe('demo');
    expect(response.body.password.length).toBe(10);
  });
});
