#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# A Script to process markdown posts with YAML Front matter
from io import BytesIO
from datetime import datetime
import argparse
import frontmatter
import os


def main():
    """TODO: Docstring for main.
    :returns: TODO

    """
    parser = argparse.ArgumentParser(description='Process markdown yaml.')
    parser.add_argument('input_dir')
    args = parser.parse_args()
    fileList = getMarkdownFileList(args.input_dir)
    processYAMLFront(fileList)


def processYAMLFront(file_list):
    for md_file in file_list:
        # print(md_file)
        with open(md_file, 'r+') as f:
            post = frontmatter.load(f)
            if not bool(post.keys()):
                print("File: ", md_file, " has no YAML front matter: ",
                      post.keys())
            else:
                post['layout'] = 'post'
                if 'time' in post.keys():
                    del post['time']
                if 'categories' in post.keys():
                    del post['categories']
                if 'category' in post.keys():
                    del post['category']
                if 'tag' in post.keys():
                    del post['tag']
                if 'tags' in post.keys():
                    tags = post['tags']
                    if isinstance(tags, str):
                        tag_list = [x.strip() for x in tags.split(' ')]
                        post['tags'] = tag_list
                post['date'] = getFileDate(md_file)
                s = BytesIO()
                frontmatter.dump(post, s)
                f.seek(0)
                f.write(s.getvalue().decode('utf-8'))
                f.truncate()
                f.close()


def getFileDate(file_path):
    filename = os.path.basename(file_path)
    try:
        time = datetime.strptime(filename[:10], "%Y-%m-%d")
        dt = str('{0:%Y-%m-%d}'.format(time))
        return dt
    except:
        print("Error parsing date on file: ", filename)


def getMarkdownFileList(dir):
    md_files = []
    for root, directories, filenames in os.walk(dir):
        for filename in filenames:
            if filename.endswith("md"):
                file_path = os.path.join(root, filename)
                # print(file_path)
                md_files.append(file_path)
    return md_files

if __name__ == "__main__":
    main()
