import mysql from 'serverless-mysql';
const db = mysql({
  config: {
    host: "localhost", 
    port: 3306,
    database: '`finallapp`',
    user: 'root',
    password: '12345678' 
  }
});
// Main handler function
export default async function excuteQuery(query: any, values: any) {
  try {
    const results = await db.query(query, values);
    await db.end();
    return results;
  } catch (error) {
    return { error };
  }
}