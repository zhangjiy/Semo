//
//  JYPaintingView.swift
//  Semo
//
//  Created by jiyang on 2022/3/20.
//

import Foundation
import UIKit
import MaLiang
import Comet
import Chrysan
import Zip

class JYPaintingView: UIView {
    var canvas: Canvas!
    
    var filePath: String?
    
    public var brushes: [Brush] = []
    var chartlets: [MLTexture] = []
    
    var color: UIColor {
        return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConfig()
        registerBrushes()
        readDataIfNeeds()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func registerBrush(with imageName: String) throws -> Brush {
        let texture = try canvas.makeTexture(with: UIImage(named: imageName)!.pngData()!)
        return try canvas.registerBrush(name: imageName, textureID: texture.id)
    }
    
    private func setupConfig() {
        chartlets = ["chartlet-1", "chartlet-2", "chartlet-3"].compactMap({ (name) -> MLTexture? in
            return try? canvas.makeTexture(with: UIImage(named: name)!.pngData()!)
        })
        canvas.backgroundColor = .clear
        canvas.data.addObserver(self)
    }
    
    private func setupView() {
        canvas = Canvas(frame: bounds)
        addSubview(canvas)
    }
    
    private func registerBrushes() {
        do {
            let pen = canvas.defaultBrush!
            pen.name = "Pen"
            pen.pointSize = 5
            pen.pointStep = 0.5
            pen.color = color
            
            let pencil = try registerBrush(with: "pencil")
            pencil.rotation = .random
            pencil.pointSize = 3
            pencil.pointStep = 2
            pencil.forceSensitive = 0.3
            pencil.opacity = 1
            
            let brush = try registerBrush(with: "brush")
            brush.opacity = 1
            brush.rotation = .ahead
            brush.pointSize = 15
            brush.pointStep = 1
            brush.forceSensitive = 1
            brush.color = color
            brush.forceOnTap = 0.5
            
            let texture = try canvas.makeTexture(with: UIImage(named: "glow")!.pngData()!)
            let glow: GlowingBrush = try canvas.registerBrush(name: "glow", textureID: texture.id)
            glow.opacity = 0.5
            glow.coreProportion = 0.2
            glow.pointSize = 20
            glow.rotation = .ahead
            
            let claw = try registerBrush(with: "claw")
            claw.rotation = .ahead
            claw.pointSize = 30
            claw.pointStep = 5
            claw.forceSensitive = 0.1
            claw.color = color
            
            /// make a chartlet brush
            let chartletBrush = try ChartletBrush(name: "Chartlet", imageNames: ["rect-1", "rect-2", "rect-3"], target: canvas)
            chartletBrush.renderStyle = .ordered
            chartletBrush.rotation = .random
            
            /// make eraser with default round point
            let eraser = try! canvas.registerBrush(name: "Eraser") as Eraser
            eraser.opacity = 1
            
            brushes = [pen, pencil, brush, glow, claw, chartletBrush, eraser]
            
        } catch MLError.simulatorUnsupported {
            let alert = UIAlertController(title: "Attension", message: "You are running MaLiang on a Simulator, whitch is not supported by Metal. So painting is not alvaliable now. But you can go on testing your other businesses which are not relative with MaLiang. Or you can also runs MaLiang on your Mac with Catalyst enabled now.", preferredStyle: .alert)
            alert.addAction(title: "确定", style: .cancel)
            //self.present(alert, animated: true, completion: nil)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(title: "确定", style: .cancel)
            //self.present(alert, animated: true, completion: nil)
        }
        
        if brushes.count > 0 {
            changeStyle(0)
        }
    }
    
    private func readDataIfNeeds() {
        guard let file = filePath else {
            return
        }
        //chrysan.showMessage("Reading...")
        
        let path = Path(file)
        let temp = Path.temp().resource("temp.zip")
        let contents = Path.temp().resource("contents")
        
        do {
            try? FileManager.default.removeItem(at: temp.url)
            try FileManager.default.copyItem(at: path.url, to: temp.url)
            try Zip.unzipFile(temp.url, destination: contents.url, overwrite: true, password: nil)
        } catch {
            self.chrysan.hide()
            let alert = UIAlertController(title: "unzip failed", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(title: "OK", style: .cancel)
            //self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        DataImporter.importData(from: contents.url, to: canvas, progress: { (progress) in
            
        }) { (result) in
            if case let .failure(error) = result {
                self.chrysan.hide()
                let alert = UIAlertController(title: "Reading Failed", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(title: "OK", style: .cancel)
                //self.present(alert, animated: true, completion: nil)
            } else {
                //self.chrysan.show(.succeed, message: "Reading Succeed!", hideDelay: 1)
            }
            
        }
    }

    @objc public func changeColor(_ color: UIColor) {
        canvas.currentBrush.color = color
    }
    
    @objc public func changeSize(_ size: CGFloat) {
        canvas.currentBrush.pointSize = CGFloat(size)
    }
    
    @objc public func changeStyle(_ index: Int) {
        let brush = brushes[index]
        brush.color = color
        brush.use()
        //sizeSlider.value = Float(brush.pointSize)
    }
    
    func togglePencilMode(_ isOn: Bool) {
        canvas.isPencilMode = isOn
    }
    
    @objc public func undo() {
        canvas.undo()
    }
    
    func redoAction() {
        canvas.redo()
    }
    
    func clearAction() {
        canvas.clear()
    }
    
    func saveData() {
        //self.chrysan.showMessage("Saving...")
        let exporter = DataExporter(canvas: canvas)
        let path = Path.temp().resource(Date().string())
        path.createDirectory()
        exporter.save(to: path.url, progress: { (progress) in
            //self.chrysan.show(progress: progress, message: "Saving...")
        }) { (result) in
            if case let .failure(error) = result {
                self.chrysan.hide()
                let alert = UIAlertController(title: "Saving Failed", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(title: "OK", style: .cancel)
                //self.present(alert, animated: true, completion: nil)
            } else {
                let filename = "\(Date().string(format: "yyyyMMddHHmmss")).maliang"
                
                let contents = try! FileManager.default.contentsOfDirectory(at: path.url, includingPropertiesForKeys: [], options: .init(rawValue: 0))
                try? Zip.zipFiles(paths: contents, zipFilePath: Path.documents().resource(filename).url, password: nil, progress: nil)
                try? FileManager.default.removeItem(at: path.url)
                //self.chrysan.show(.succeed, message: "Saving Succeed!", hideDelay: 1)
            }
        }
    }
    
}

extension JYPaintingView: DataObserver {
    /// called when a line strip is begin
    func lineStrip(_ strip: LineStrip, didBeginOn data: CanvasData) {
        //self.redoButton.isEnabled = false
    }
    
    /// called when a element is finished
    func element(_ element: CanvasElement, didFinishOn data: CanvasData) {
        //self.undoButton.isEnabled = true
    }
    
    /// callen when clear the canvas
    func dataDidClear(_ data: CanvasData) {
        
    }
    
    /// callen when undo
    func dataDidUndo(_ data: CanvasData) {
        //self.undoButton.isEnabled = true
        //self.redoButton.isEnabled = data.canRedo
    }
    
    /// callen when redo
    func dataDidRedo(_ data: CanvasData) {
        //self.undoButton.isEnabled = true
        //self.redoButton.isEnabled = data.canRedo
    }
}

extension String {
    var floatValue: CGFloat {
        let db = Double(self) ?? 0
        return CGFloat(db)
    }
}


