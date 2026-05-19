import { NextRequest, NextResponse } from 'next/server';
import sql from '../../lib/db';

export async function GET() {
  const products = await sql`
    SELECT p.id, p.name, p.price, p.stock, c.name AS category
    FROM products p
    INNER JOIN categories c ON p.category_id = c.id
    ORDER BY c.name
  `;
  return NextResponse.json(products);
}

export async function POST(request: NextRequest) {
  const { name, price, stock, category_id } = await request.json();
  
  const result = await sql`
    INSERT INTO products (name, price, stock, category_id)
    VALUES (${name}, ${price}, ${stock}, ${category_id})
    RETURNING *
  `;
  return NextResponse.json(result[0], { status: 201 });
}