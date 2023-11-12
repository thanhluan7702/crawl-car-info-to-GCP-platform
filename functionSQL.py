import mysql.connector

def create_car_table(cursor): 
    query = '''
    CREATE TABLE IF NOT EXISTS CAR_DETAIL (
    `Mã tin` INT PRIMARY KEY,
    `Xuất xứ` TEXT,
    `Tình trạng` TEXT,
    `Dòng xe` TEXT,
    `Số Km đã đi` TEXT,
    `Màu ngoại thất` TEXT,
    `Màu nội thất` TEXT,
    `Số cửa` TEXT,
    `Số chỗ ngồi` TEXT,
    `Động cơ` TEXT,
    `Hệ thống nạp nhiên liệu` TEXT,
    `Hộp số` TEXT,
    `Dẫn động` TEXT,
    `Tiêu thụ nhiên liệu` TEXT,
    `Mô tả` TEXT,
    `Hãng` TEXT,
    `Grade` TEXT,
    `Năm sản xuất` TEXT,
    `Tên xe` TEXT,
    `Giá` TEXT,
    `URL` TEXT
    )'''

    cursor.execute(query)
    return

def create_seller_table(cursor): 
    # BUYER
    query = '''
    CREATE TABLE IF NOT EXISTS SELLER (
    `Mã tin` INT PRIMARY KEY,
    `Tên` TEXT, 
    `Địa chỉ` TEXT, 
    `Website` TEXT, 
    `Điện thoại 1` TEXT, 
    `Điện thoại 2` TEXT
    )'''

    cursor.execute(query)
    return 


def customize_query(cursor, query = None): 
    if query == None: 
        return 'Invalid syntax'
    
    cursor.execute(query)
    myresult = cursor.fetchall()
    return myresult

def insert_car_data(data, conn, cursor): 
    cursor.execute('''INSERT IGNORE INTO CAR_DETAIL 
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                    ''', data)
    conn.commit()
    return

def insert_seller_data(data, conn, cursor): 
    # BUYER
    cursor.execute('''INSERT IGNORE INTO SELLER
                    VALUES (%s, %s, %s, %s, %s, %s)
                    ''', data)
    conn.commit()
    return

def connect_database():
    config = {
        'user': 'thanhluan7702',
        'password': 'thanhluan7702',
        'host': '34.143.130.226',
        'database': 'databasecar',
        'port' : '3306'
    }

    cnx = mysql.connector.connect(**config)

    if cnx.is_connected():
        print("Đã kết nối đến cơ sở dữ liệu MySQL")
    else:
        print("Không thể kết nối đến cơ sở dữ liệu MySQL")

    cursor = cnx.cursor()
    return cnx, cursor


cnx, cursor = connect_database()
# create_car_table(cursor)
# create_buyer_table(cursor)

import pandas as pd 
tables_1 = pd.DataFrame(customize_query(cursor, 'SELECT * FROM SELLER')) #BUYER
tables_1.columns = ['Mã tin', 'Tên', 'Địa chỉ', 'Website', 'Điện thoại 1', 'Điện thoại 2']
tables_1.to_csv('seller.csv', index = False, encoding='utf-8')


tables_2 = pd.DataFrame(customize_query(cursor, 'SELECT * FROM CAR_DETAIL'))
tables_2.columns = ['Mã tin', 'Xuất xứ', 'Tình trạng', 'Dòng xe', 'Số Km đã đi', 'Màu ngoại thất', 
                                         'Màu nội thất', 'Số cửa', 'Số chỗ ngồi', 'Động cơ', 'Hệ thống nạp nhiên liệu', 
                                         'Hộp số', 'Dẫn động', 'Tiêu thụ nhiên liệu', 'Mô tả', 'Hãng', 'Grade', 'Năm sản xuất', 
                                         'Tên xe', 'Giá', 'URL']
tables_2.to_csv('car_detail.csv', index = False, encoding='utf-8')